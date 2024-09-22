# Assignment 1: Design a Logical Model

## Question 1
Create a logical model for a small bookstore. 📚

At the minimum it should have employee, order, sales, customer, and book entities (tables). Determine sensible column and table design based on what you know about these concepts. Keep it simple, but work out sensible relationships to keep tables reasonably sized. Include a date table. There are several tools online you can use, I'd recommend [_Draw.io_](https://www.drawio.com/) or [_LucidChart_](https://www.lucidchart.com/pages/).

Answer:  
![image](https://github.com/user-attachments/assets/42951d68-0f99-4730-8cc7-a2cd87644508)



## Question 2
We want to create employee shifts, splitting up the day into morning and evening. Add this to the ERD.

Answer:  
![image](https://github.com/user-attachments/assets/51b3625c-ab63-45bc-804a-e1ccab058b1a)


## Question 3
The store wants to keep customer addresses. Propose two architectures for the CUSTOMER_ADDRESS table, one that will retain changes, and another that will overwrite. Which is type 1, which is type 2?

_Hint, search type 1 vs type 2 slowly changing dimensions._

Type 1 Slowly Changing Dimensions: Overwrite  
Schema architecture for customer_address table. This is for type 1, where the changes overwrite previous records.  
![image](https://github.com/user-attachments/assets/863de839-5bd0-482b-801c-54b78fea4223)

Type 2 Slowly Changing Dimensions: Retain Changes  
Schema architecture for customer_address table. This is for type 2, where the historical changes are kept and can compare older version(s) to the current version.  
![image](https://github.com/user-attachments/assets/45807f6d-0be7-41b2-8698-bb54bab56935)



Bonus: Are there privacy implications to this, why or why not?
```
There are privacy implications to including address information for either schema version. As a general statement, including customer address information is another instance of storing personal information, which must follow important laws regarding privacy.

In the type 1, overwrite changes, only one address record is stored per customer. New updates to data will overwrite the historical or previous record and reduces the amount of personal information stored.
This may protect customers, where if there is a data breach, less of their personal information is at risk.
This is also an efficient manner of storing data, by reducing the total number of records that need to be stored.

In type 2, retain changes, multiple address records may be stored per customer.
If a customer has an address change, their previous address will be maintained as a record. Updates to the start date, end date and current flag will indicate when that address was the up-to-date record for the customer.
The newest or current record will usually have a recent date for the start date column, either a blank, null or 'improbable' value for the end date, and the current flag will indicate 1 or True.
As for privacy implications, this information is riskier to store for customers.
More of their data is available and would require more extensive privacy protection to prevent breaches or accidental leaks.
With more data available, the risk of storing personal information increases.
These sorts of storage methods may be useful for longitudinal studies and other exposure studies to keep track of when customers may have been exposed to a specific risk.  
```

## Question 4
Review the AdventureWorks Schema [here](https://i.stack.imgur.com/LMu4W.gif)

Highlight at least two differences between it and your ERD. Would you change anything in yours?
```
Overall, the AdventureWorks schema was quite interesting. It had many more boxes than mine, and likely pursues much more detail about indidividual pieces of information related to the database schema.

1)
The first major difference would be the structure of the ERDs. My ERD is quite small, it only has 6-7 tables, whereas the AdventureWorks ERD has many more. However, the interesting difference is the grouping of tables.
Albeit, my ERD is quite small, so it is difficult to create groupings. However, the AdventureWorks table created an umbrella of groupings with colour codes. All the tables related to production, purchasing, person, sales and human resources are grouped together.
Within these groups, the relationships between the tables are displayed with the arrows, like a typical ERD. There a few tables in each group which then connect to another table that belongs to an adjacent 'group'.
Overall, I believe this is a well structured design. It creates smaller, organized groupings of tables to allow for easier understanding of the relationships. Then, relationships between tables in other groups can be identified.

2)
Another difference noticed in the AdventureWorks ERD to my ERD was the presence of the 'ModifiedDate' in all the tables. This appears to be a variable to track the most recent changes to any of the tables that exist within the database.
It is likely useful in adding/updating data in tables, moving, renaming or even creating new tables. I also think this is a great structure to have in the database as it guides change management, data quality control and may be useful for other project management goals.

For something I would change in my database, I would definitely implement the grouping system if I were to add more tables. I think keeping a well-structured RDBMS ensures data is easier to retrieve. It will make it easier for users to read and ERD to understand.

I would also like to include a dbo group. The tables involved in this group allow for tracking of the overall system. These tables can provide almost a meta-data overview of changes to the database and other logs that occur.
This group could be beneficial in tracking errors, change management and people who have accessed the database. This information is vital to quality insurance. Keeping database information in a table like this allows for quick retrieval of this required information. I would use this information to identify who is using the data and ensure it has been used correctly. I would use this table as a key component in other business analytics.
This would include but is not limited to, reshaping the database, creating new connects, adding/removing tables and checking issues that occured within the database.

Overall, I appreciate the ERD system. Although it does appear to be complex on first sight, with further review of the image, the tables are neatly organized, and the data is well presented. Many of the design principles in the ERD, could aid one that would design a complex database system.
```

# Criteria

[Assignment Rubric](./assignment_rubric.md)

# Submission Information

🚨 **Please review our [Assignment Submission Guide](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md)** 🚨 for detailed instructions on how to format, branch, and submit your work. Following these guidelines is crucial for your submissions to be evaluated correctly.

### Submission Parameters:
* Submission Due Date: `September 28, 2024`
* The branch name for your repo should be: `model-design`
* What to submit for this assignment:
    * This markdown (design_a_logical_model.md) should be populated.
    * Two Entity-Relationship Diagrams (preferably in a pdf, jpeg, png format).
* What the pull request link should look like for this assignment: `https://github.com/<your_github_username>/sql/pull/<pr_id>`
    * Open a private window in your browser. Copy and paste the link to your pull request into the address bar. Make sure you can see your pull request properly. This helps the technical facilitator and learning support staff review your submission easily.

Checklist:
- [ ] Create a branch called `model-design`.
- [ ] Ensure that the repository is public.
- [ ] Review [the PR description guidelines](https://github.com/UofT-DSI/onboarding/blob/main/onboarding_documents/submissions.md#guidelines-for-pull-request-descriptions) and adhere to them.
- [ ] Verify that the link is accessible in a private browser window.

If you encounter any difficulties or have questions, please don't hesitate to reach out to our team via our Slack at `#cohort-4-help`. Our Technical Facilitators and Learning Support staff are here to help you navigate any challenges.
