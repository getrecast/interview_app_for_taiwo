# README


## About 
This is a basic application where user can create spend forecast objects, by uploading budget csv and
setting constraints.

### Current state of the app
User is able to:
* Create and persist spend forecast object. Forecast object can persist budget and budgets constraints, like `start_date`, `end_date`. Budget is uploaded as a csv in the form.
* When a spend forecast object is being created, even if it contains errors, it is persisted.
* Download spend forecast budget csv's and csv template.
* View forecast objects.

See `data/budget.csv` for a budget template. In body first col is date and other rows are spend, which
is expected to be a decimal representing dollars.

### Requirements
* Ruby 3.2.2
* bundler
