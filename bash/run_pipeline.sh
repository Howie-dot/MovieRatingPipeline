#!/bin/bash

# ========== CONFIGURATION ==========
KAGGLE_JSON_PATH=~/team19/.kaggle/kaggle.json
DATASET_PATH=~/team19/data

# List of datasets (Format: "dataset-name|kaggle-slug")
DATASETS=(
    "tmdb-movies|asaniczka/tmdb-movies-dataset-2023-930k-movies"
    "tv-movie-metadata|gayu14/tv-and-movie-metadata-with-genres-and-ratings-imbd"
)

# ========== STEP 1: CHECK KAGGLE API SETUP ==========
echo "Checking Kaggle API setup..."
if [ ! -f "$KAGGLE_JSON_PATH" ]; then
    echo "ERROR: kaggle.json not found at $KAGGLE_JSON_PATH"
    exit 1
fi

# Extract username and key from kaggle.json
KAGGLE_USERNAME=$(jq -r .username $KAGGLE_JSON_PATH)
KAGGLE_KEY=$(jq -r .key $KAGGLE_JSON_PATH)

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    sudo apt-get update && sudo apt-get install -y jq
fi

# Create data directory if it doesn’t exist
mkdir -p $DATASET_PATH

# ========== STEP 2: DOWNLOAD DATASETS FROM KAGGLE ==========
echo "Downloading datasets from Kaggle..."
for DATA in "${DATASETS[@]}"; do
    DATASET_NAME=$(echo $DATA | cut -d "|" -f 1)
    KAGGLE_SLUG=$(echo $DATA | cut -d "|" -f 2)

    echo "Downloading dataset: $DATASET_NAME..."
    
    wget --header="Authorization: Kaggle $KAGGLE_USERNAME:$KAGGLE_KEY" \
         -O $DATASET_PATH/$DATASET_NAME.zip \
         "https://www.kaggle.com/api/v1/datasets/download/$KAGGLE_SLUG"

    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to download $DATASET_NAME!"
        continue
    fi

    echo "Unzipping dataset: $DATASET_NAME..."
    unzip -o $DATASET_PATH/$DATASET_NAME.zip -d $DATASET_PATH/
done

echo "All Kaggle datasets downloaded and extracted successfully."

# ========== STEP 3: DOWNLOAD CPI DATA ==========
echo "Downloading CPI data from FRED..."

CPI_URL="https://fred.stlouisfed.org/graph/fredgraph.csv?id=CPIAUCSL"
CPI_FILE="$DATASET_PATH/CPI_data.csv"

wget --no-check-certificate --user-agent="Mozilla/5.0" "$CPI_URL" -O "$CPI_FILE"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to download CPI data!"
else
    echo "CPI data downloaded successfully: $CPI_FILE"
fi
