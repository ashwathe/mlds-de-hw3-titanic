library(tidyverse)
library(caret)

print("Starting Titanic pipeline in R...")

df <- read.csv("data/train.csv")

# Clean data
df <- df %>%
  distinct() %>%
  mutate(
    Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age),
    Fare = ifelse(is.na(Fare), median(Fare, na.rm = TRUE), Fare),
    Embarked = ifelse(is.na(Embarked), Mode(Embarked), Embarked),
    Sex = ifelse(Sex == "male", 0, 1),
    FamilySize = SibSp + Parch + 1
  )

df$Embarked <- as.factor(df$Embarked)
df <- df %>% mutate(Embarked = fct_relevel(Embarked, "S"))

# Train/test split
set.seed(42)
train_index <- createDataPartition(df$Survived, p = 0.8, list = FALSE)
train <- df[train_index, ]
test <- df[-train_index, ]

model <- train(Survived ~ Pclass + Age + Fare + Sex + FamilySize + Embarked,
               data = train, method = "glm", family = "binomial")

print(paste("✅ Model trained. Accuracy:",
            round(mean(predict(model, train) == train$Survived), 3)))

dir.create("outputs", showWarnings = FALSE)
preds <- data.frame(
  PassengerId = test$PassengerId,
  PredictedSurvival = predict(model, test)
)
write.csv(preds, "outputs/predictions_R.csv", row.names = FALSE)
print("Predictions saved → outputs/predictions_R.csv")
