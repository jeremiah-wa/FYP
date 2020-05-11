# FYP
## Multi-criteria recommender

#### How to:
- Download TripAdvisor.csv file and FYP notebook
- Use jupyter Notebooks to run notebook.
- Preferably run notebook cell by cell. Some of the cells (validation, testing and recommendation generation, etc.) require extensive processing time.
- The results will print on corresponding csv files

The dataset used for the experiment (TripAdvisor.csv) was filtered from a SQL table (review.sql). I used the tripadvisor.sql to query the table and retrieve a Tripadvisor table which I then exported to csv. The reviews.sql and tripadvisor.sql files can be found in the SQL.zip file.

### TripAdvisor dataset

This cell creates table (dataframe) from TripAdvisor dataset filtered from TripAdvisor SQL relational

### Pre-processing

After filtering the data from the SQL files. Some extra pre-processing was required. This involved the following:
- **Removing duplicates:** remove multiple reviews of a distinct hotel by one user. This 
- **parsing html:** removing tag and other syntax from review text

I had not accounted for duplicate reviews in the original dataset. To account for the offset created when I removed the duplicates the minimum number of reviews per user and hotel had to be reset to 3. This was still a  sufficient number of reviews for the training, validation, test split.

### User-item Matrix

Analysis of user-item matrix created by TripAdvisor dataset (referenced in Report 7. Data)

####  Density

A very low density level means less chance of overlap which will negatively affect the size and quality of the neighbourhoods.

#### User-to-user matrix

Here I have created a user by user matrix with binary entries. 1 indicates a pair of users have co-rated items, 0 indicates there are no co-rated items. We can get an understanding of the overlaps between the users by computing the density of this matrix, however because, for a given user, I only care about the correlation with other users I will remove Mij where i=j, thus giving the percentage of correlated different users.

#### Item-to-item matrix

Similarly, the item-to-item matrix


### Distribution of Reviews per user and hotels

This cell defines the function used to graph the distributions of Number of Reviews per user/hotel.

#### Overall dataset graphs

Graphs illustrate the distribution of number of reviews per proportion of users and hotels in the overall dataset. This help me understand the likelihood of overlap in the dataset. Both users and hotels reviews had a right skewed distribution. More than 40% of users had 5 reviews. More than 10% of hotels had the minimum of 3 reviews.

### Random Training, Validation, Test set split

- Traing set: ~80% of overall dataset.
- Validation set: ~10% of overall dataset. Any users/hotels not in found in training dataset are removed
- Test set: ~10% of overall dataset. Any users/hotels not in found in training dataset are removed

This cell defines the function for  randomly spliting the TripAdvisor dataset into the training, validation and test sets.

### Distribution of Reviews per user and hotels

The following graph illustrate the distribution of number of reviews per proportion of users and hotels in the training, validaion and test sets.

#### Training graphs

For the most part the graphs retains the same characteristic as the distribution of the overall dataset.

#### Validation graphs

#### Test graphs

The characteristic of the distribution are more dramatic in the smaller validation and test sets.

## Collaborative Filtering (CF)

This cell houses the CF recommender class object. **It is necessary to run this cell in order to define the cf_recommender object.** This recommender object can be configured to perform all the CF approaches mentioned in Ch 8 of the report.

#### Evaluation function
**Its is necessary to run this cell**
Used to test the recommenders on the evaluation metrics, RMSE and Coverage over a given set. Used for validaton testing and final evaluation of MC and CF recommenders. Function also returns the average neighbourhood size for additional analysis

Paramters: 
- recs - recommender object (cf / mc)
- evalset - evaluate to be used set (valdiation/test set) 
- ub - boolean variable to identify the approach being used (user-based or item-based) 

Returns: 
- RMSE
- Coverage
- Average Neighbourhood size

### Validation Testing Functions

The following functions are used for testing CF and MC recommmender with different parameters. **It is necessary to run the test function cells**

- test_knn: performs testing on a CF or MC model using the KNN algorithm on a range of k values (10-250) 
- test_threshold: performs testing on a CF or MC model using Threshold neighbourhood algorithm on range of threshold values (0,90)
-test_sig: performs testing on a CF or MC model using significance weighting on range of weight values (1,10) 

All test function use the evaluation function to compute results
All test functions print out and store results in table as they are processed


#### Print validation result to CSV
This cell defines the function for printing the valdiation tests to csv
**It is necessary to run this cell**

## Validation Testing - CF

Conducted testing on Pearson, Cosine and MSD metrics using KNN and threshold neighbourhood generation algorithms. (referenced in Report Ch 9.1)
**Each test takes approx. 5-10 mins to complete.**

### KNN algorithm

##### User-based

Using the test_knn function I perform testing on a User-based CF model using pearson, cosine and MSD similarity metrics. The tests are performed with the validation set

#####  Item-based

similarly knn testing is performed on a Item-based CF model

### Threshold neighbourhood algorithm

#### User-based

Using the test_threshold function I perform testing on a User-based CF model using pearson, cosine and MSD similarity metrics. The tests are performed with the validation set.

#####  Item-based

similarly threshold testing is performed on a Item-based CF model

#### print results to csv

All results are then printed to a corresponding csv

###  Significance weighting

Additionally I tested the effects of significance weighting on a user-based CF model using the Pearson metric and print the results to a corresponding csv.


## Multi-criteria recommender (MC)

This cell houses the MC recommender class object. **It is necessary to run this cell in order to define the mc_recommender object** This recommender object can be configured to perform all the MC approaches mentioned in Ch 8 of the report.

## Validation Testing - MC

Conducted testing on Pearson, Cosine and MSD metrics using KNN and threshold neighbourhood generation algorithms. (referenced in Report Ch 9.1)
**Each test takes approx. 5-10 mins to complete.**

### KNN algorithm

##### User-based

Using the test_knn function I perform testing on a User-based MC model using pearson, cosine and MSD similarity metrics. The tests are performed with the validation set

#####  Item-based

similarly knn testing is performed on a Item-based MC model

### Threshold neighbourhood algorithm

#### User-based

Using the test_threshold function I perform testing on a User-based MC model using pearson, cosine and MSD similarity metrics. The tests are performed with the validation set.

#####  Item-based

similarly threshold testing is performed on a Item-based CF model

#### print results to csv

All results are then printed to a corresponding csv

###  Significance weighting

Additionally I tested the effects of significance weighting on a user-based MC model using the msd metric and print the results to a corresponding csv.


## Evaluation - CF vs MC

Compare the highest performing algorithms from both CF and MC approaches. This cell contains the final evaluation test for CF and MC algorithms. 
**Evaluation test takes for approx. 5-10 mins to complete**

## Content-based (CB)

This cell contained the CB recommender object class.**It is necessary to run this cell to define the cb_recommender object.** This recommender object can be configured to perform all the CB approaches mentioned in Ch 8 of the report.

Similarity between term vector is computed using the cosine similarity metric (note the vectors were normalized so cosine is given by the dot product of the vectors).

In this dataset, it was found that similarity can be found for every vector pair so to reduce the time complexity of the algorithm, the number of neighbour profiles was fixed to 100.

## Recommendations

This cell houses the function used to generate recommendation for profiles with relevant profiles in the test set.

#### Create table for recommendations

This cell creates a table to store recommendation. It is necessory to store recommendations as a table before saving as csv.

### Generate Recommendations

The following cells generated recommendation using of the three approaches and store them as dictionarys (maps). Key-value pairs with active users as keys and list of recommendation tuples which consist of recommended items and their corresponding predicted ratings/similarity score.
**Each recommendation generation takes 20-30 mins to complete.**


## Evaluation -  CF vs MC vs CB

The evaluation of the three approaches CF, MC and CB were be conducted over their recommendation of user profiles in the test set(mentioned in Ch 8). Only users with revelant items in  the test set (truth set) were considered. Revelant items are defined as items that recieved a rating >= 4. The three approaches were evaluated under three evaluation metrics: Mean Average Precision, Average Diversity and Coverage (mentioned in Ch 9.1)


#### Average Precison (AP)

This cell contains the function for computing Average precision (mentioned in 9.1 of Report). It returns the Average precision for N recommendations.

#### Precison vs Recall Graph

This cell graphs a precision vs recall curve for a certain users recommendations.
This curve only illustrates the scores for N recommendations made for a certain user. In this example, the user profile that appeared the most in the test set was selected and the number of recommendations (N) was set to 150.


#### Mean Average Precsion (MAP)

This cell contains the function which computes the mean average precision for a given N recommendations of all users that were recommended (users in recommended set). Using this function we can gain an understanding of the quality of the recommendations made.

### MAP of CF, MC and CB Recommendations

This cell computes the MAP for the N recommendations made by the three approaches. The MAP of a range of N values is calculated (10-300).

#### Diversity 

This cell computes the diversity of a given user's recommendations for up to N recommendations (reference Ch 9.1)

#### Average Diversity

This cell uses the diversity function to compute the average diversity of all items recommended (recommended set) for N recommendations

### Average Diversity for CF, MC and CB recommendations

This following cells computes the average diversity of the three approaches for varying numbers of recommendations (10-100).

To compute diversity the similarity between the recommended items is needed, however the user-based CF and MC recommenders only store the similarity between the user so it is necessary to create corresponding item-based recommenders to generate an item-to-item similarity matrix.This is not the case for content-based recommendations where the recommedations are based on the similarity of items rated by the users, so the similarity matrix for items is already present in the recommender object.

### Coverage

The Coverage of the recommendations is defined as proportion of user profiles in the truth set that a recommendation was generated i.e. number of users for which recommendations can be made / number of users in the truth set.









