[![CircleCI](https://circleci.com/gh/TheJudgeMonkey/ads-app/tree/main.svg?style=svg)](https://circleci.com/gh/TheJudgeMonkey/ads-app/tree/main) [![Heroku](https://pyheroku-badge.herokuapp.com/?app=calm-island-92931&style=<STYLE>)](https://calm-island-92931.herokuapp.com/)

# ADS-APP

[Project on heroku](https://calm-island-92931.herokuapp.com/)

## Setup 

### Prerequisites
- node 16.8.0
- ruby 3.0.0
- PostgreSQL 12.8.0
- RMagick (see below)

#### RMagick for Ubuntu
```bash
sudo apt-get update
sudo apt-get install libmagickcore-dev libmagickwand-dev
```

#### RMagick for Mac
```bash
brew install pkg-config imagemagick
```

### For all systems

```bash
git clone git@github.com:TheJudgeMonkey/ads-app.git
cd ads-app
gem install bundler:2.2.26
bundle
yarn
rails db:setup
rails s
```
