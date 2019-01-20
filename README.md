# README

## Setup

Before starting, make sure you have all dependencies installed:

### Dependencies:
- Ruby 2.3.3
- MySQL 5.6
- NPM 5.6.0
- Bundler 1.16.0

Now you can start running the app. The app consists of a Ruby on Rails API backend, and a React front end.

To get the app running:

1. Install gem dependencies:
```
> bundle
```

2. Setup and seed the database:
```
> rake db:create db:migrate db:seed
```

3. Run the server, ensuring to run it on port 3001:
```
> rails s -p 3001
```

The backend should now be running, you can check by going to `http://localhost:3001/` in your browser, where you will see a rails confirmation message.

Now its time to run the front end.

4. In a new console window, navigate to `/client`

5. Install dependencies:
```
> npm install
```

6. Run the app in development mode:
```
npm run start
```

The app is now running, and accessible under `http://localhost:3000/`

## Tests

The app contains Rspec test for the Ruby on Rails backend, and Jest snapshot tests for the React front end.

### Rspec

1. Setup the test database:
```
> RAILS_ENV=test rake db:create db:migrate
```

2. Run the test suite:
```
> rspec
```

### Jest

In the `client` folder run:
```
> npm test
```
Launches the test runner in the interactive watch mode.
