# SofaPop

_This project was built as a part of the contributor's study at the [Turing School of Software and Design](https://turing.io/). It was designed to teach basic authentication within a Rails application as well as how to consume an API which itself requires authentication._

Browse movies, create watch parties, and invite friends from one convenient dashboard-based application! Not sure what to watch with the gang? Check out current top rated movies, or search for an old favorite. View movie info including current user rating, cast, film length and more. Keep track of your watch parties on your dashboard, and invite friends to parties you host using their account email.

## Contributors

  - [Alex Schwartz](https://www.linkedin.com/in/alex-s-77659758/)
  - [Adam Bowers](https://www.linkedin.com/in/adam-bowers-06a871209/)
  - [Wil McCauley](https://www.linkedin.com/in/wil-mccauley/)

## Live App

Visit the [SofaPop application site](https://morning-garden-45424.herokuapp.com/) and get the party started!

## Index

  - [Getting Started](#getting-started)
  - [Installing](#installing)
  - [Test Suite](#test-suite)
  - [Functionality](#functionality)
  - [Acknowledgments](#acknowledgments)

## Getting Started

### Prerequisites

This project is built with:
- Rails 2.5.5
- Ruby 2.5.3

### Installing

1. Clone this repo:
  ```sh
  $ git clone git@github.com:Wil-McC/viewing_party.git
  ```

2. Install dependencies:
  ```sh
  $ bundle install
  ```

3. Setup database:
  ```sh
  $ rails db:{drop,create,migrate}
  ```

## Test Suite

This app uses RSpec for testing. Run the test suite with:
```sh
$ bundle exec rspec
```

## Functionality
After logging in, your user dashboard shows all of your friends and current viewing parties:
>![Dashboard](https://user-images.githubusercontent.com/14796798/113232310-86be4980-9262-11eb-8ef7-b5e03c02dbe4.png)

By clicking 'Discover Movies' you can search for a movie by name, or click the links for other lists:
>![Search](https://user-images.githubusercontent.com/14796798/113232465-c6853100-9262-11eb-8944-ac6892a63b86.png)

Clicking on a result leads you to a details page for that movie:
>![Result List](https://user-images.githubusercontent.com/14796798/113232552-f7fdfc80-9262-11eb-920f-6a5adb03600f.png)

Here, you can create a viewing party for that movie:
>![Movie Info](https://user-images.githubusercontent.com/14796798/113232692-46130000-9263-11eb-84b8-0dccedab1427.png)

Add your time & invite your friends. Create the party, and you'll see it now on your dashboard!
>![Create Viewing Party](https://user-images.githubusercontent.com/14796798/113234686-5e851980-9267-11eb-83e1-a9abc8cc6dc9.png)
>![Viewing Party Added](https://user-images.githubusercontent.com/14796798/113234827-a0ae5b00-9267-11eb-8f89-cdd5550f14f4.png)

## Acknowledgments

<img src="https://www.themoviedb.org/assets/2/v4/logos/v2/blue_square_2-d537fb228cf3ded904ef09b136fe3fec72548ebc1fea3fbbd1ad9e36364db38b.svg" alt="The MovieDB Logo" width="75px" style="margin:10px"> Thank you to <a href="https://www.themoviedb.org/about/logos-attribution">The MovieDB</a> for providing the movie data that is used in this application.
