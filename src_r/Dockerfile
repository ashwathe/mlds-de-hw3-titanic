FROM r-base:4.3.1

# Install system dependencies for tidyverse and caret
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev libssl-dev libxml2-dev build-essential libfontconfig1-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy and install R packages first
COPY src_r/install_packages.R /app/install_packages.R
RUN Rscript /app/install_packages.R || Rscript -e "install.packages(c('tidyverse','caret'), repos='https://cloud.r-project.org')"

# Copy the main R script
COPY src_r /app/src_r

CMD ["Rscript", "/app/src_r/main.R"]
