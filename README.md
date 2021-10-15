# README

## Notes
![image](https://user-images.githubusercontent.com/22609918/137487259-de2cb53e-ea65-410d-9be0-87c42f32abab.png)

as you can see in the picture, each user has one team and every team can have many players and matches.
i also attached a postman collection for testing.
### Date
2021 October 15th
### Location of deployed application
sorry i didn't have the time to find something online
### Time spent
4 hours.
### Assumptions made
the security implementation is using JWT. if there are 2 application comunicating which each other i would use secure api key but since we have alot of users this approach doesn't make sense. that's why i use JWT. it's secure and also expirable incase a user should not have access after sometime.
### Shortcuts/Compromises made
i didn't want to spend too much time but in normal case i would have refactor the services to have the rendering data. seperated, something like a representer. trailblazer would have been a good option as well. and also in real cases, i wouldn't start until i had all the requirements. ialso would have add more test, including the commands and models.
