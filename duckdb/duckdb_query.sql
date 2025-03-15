CREATE TABLE IF NOT EXISTS movies AS 
    SELECT * FROM read_csv_auto('../data/movies_df.csv');

-- Ensure correct data types
ALTER TABLE movies ALTER revenue TYPE DOUBLE;
ALTER TABLE movies ALTER budget TYPE DOUBLE;
ALTER TABLE movies ALTER vote_average TYPE DOUBLE;

CREATE OR REPLACE VIEW measures_executive_summary AS (
    SELECT 
        EXTRACT(year FROM release_date) AS year,
        genres,
        COUNT(*) AS movie_count,
        SUM(revenue) AS total_revenue,
        AVG(revenue) AS avg_movie_revenue,
        SUM(budget) AS total_budget,
        AVG(budget) AS avg_budget,
        AVG(vote_average) AS avg_movie_rating
    FROM movies
    WHERE revenue > 0
    GROUP BY ROLLUP (year, genres)
);

-- Ratings vs. Revenue
CREATE OR REPLACE VIEW scatter_ratings_vs_revenue AS (
    SELECT vote_average, revenue
    FROM movies
    WHERE revenue > 0
);


-- Monthly Revenue Trends
CREATE OR REPLACE VIEW scatter_budget_vs_revenue AS (
    SELECT budget, revenue
    FROM movies
    WHERE budget > 0 AND revenue > 0
);

-- Revenue by Director
CREATE OR REPLACE VIEW bar_revenue_by_director AS (
    SELECT director, SUM(revenue) AS total_revenue
    FROM movies
    WHERE director IS NOT NULL AND revenue > 0
    GROUP BY director
    ORDER BY total_revenue DESC
    LIMIT 20  -- Top 20
);

-- Revenue by Genre
CREATE OR REPLACE VIEW bar_revenue_by_genre AS (
    SELECT genres, SUM(revenue) AS total_revenue
    FROM movies
    WHERE genres IS NOT NULL AND revenue > 0
    GROUP BY genres
    ORDER BY total_revenue DESC
);

