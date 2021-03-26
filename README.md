Online Courses Portal

Title: Build an online courses portal that will show a list of all available courses from various
providers like Udemy, Codecademy, etc.

Technologies: Choose from the below list only
Backend (any): Node.js using Express or Java or Ruby on Rails or Elixir or .NET
Front-end (any): Vue.js or React.js or Angular.js or Ember.js or
Rails App using above rails app as an API.
Relational Database (any): MySQL or PostgreSQL
Type(any): RESTful APIs or GraphQL APIs

Requirements:
1. Auth: This web application can have many users who can register (signup) and log-in.
This is an authentication module.
2. Fetch and Collect Courses Data: Integrate the following providers:
◆ Futurelearn https://www.futurelearn.com/feeds/courses
◆ Canvas https://www.canvas.net/products.json
◆ Codecademy https://www.codecademy.com/catalog/all.json
The application should fetch courses from these providers and store the courses in the
Database. This should be handled via a background job.
3. Display Courses: The application will have a simple home page that will show a list of all
the courses from various providers.
- Those courses should be listed in the form of a Tile of cards. Example:
https://www.udemy.com/topic/aws-certification/

- Each course card should show the course-image, title, description, rating, pricing.
Clicking on each card should open the course in the new tab.
- For pagination, add infinite scrolling (scrolling down should load the next page of
courses.)
- Filtering based on course type, providers.

4. Rate Courses: Users should be able to rate the courses. Ratings should be visible on the course card.
