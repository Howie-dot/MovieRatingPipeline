# Group 19 MSBA 405 Pipeline (Final Project)
# Pipeline to Understanding Movie Revenue, Ratings, and Industry Trends 

## Data Description

### Data Source
For this analysis, we used a total of three datasets:

We went to this page https://www.kaggle.com/datasets/asaniczka/tmdb-movies-dataset-2023-930k-movies/data and downloaded the Movies data from 2008 - 2023 in csv format. 

We also downloaded genre, lead actors, and movie directors information from: 

https://www.kaggle.com/datasets/gayu14/tv-and-movie-metadata-with-genres-and-ratings-imbd 

We then downloaded the inflation rate data from the Federal Reserve Economic Database: 

https://fred.stlouisfed.org/graph/?g=rocU 

### Data Download
In order to download the data from kaggle, you need to set up Kaggle API

1. **Go to [Kaggle](https://www.kaggle.com/account) → API → Create New API Token**  
2. **Download `kaggle.json` and replace the placeholder in `team19/.kaggle/`**  
   ```sh
   mv kaggle.json ~/team19/.kaggle/
   chmod 600 ~/team19/.kaggle/kaggle.json
   ```
3. **The bash pipeline `run_pipeline.sh` will automatically download the dataset into the data pipeline**



