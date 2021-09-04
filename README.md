[![CircleCI](https://circleci.com/gh/TheJudgeMonkey/ads-app/tree/main.svg?style=svg)](https://circleci.com/gh/TheJudgeMonkey/ads-app/tree/main) [![Heroku](https://pyheroku-badge.herokuapp.com/?app=calm-island-92931&style=<STYLE>)](https://calm-island-92931.herokuapp.com/)

# ADS-APP

[Project on heroku](https://calm-island-92931.herokuapp.com/)

## Setup for Ubuntu Linux

```bash
git clone git@github.com:TheJudgeMonkey/ads-app.git
cd ads-app
sudo apt-get update
sudo apt-get install libmagickcore-dev libmagickwand-dev
gem install bundle
bundle
yarn
rails db:setup
rails s
```
