# notorious
Note-taking app built using Elm, Netlify, and FaunaDB

- [notorious](#notorious)
  - [Notes](#notes)
  - [Get the Netlify CLI](#get-the-netlify-cli)
  - [Add FaunaDB](#add-faunadb)
  - [Run locally](#run-locally)

## Notes

- Netlify CI runs on push to master
- Fauna has built in GraphQL support
- Netlify and Fauna are set up using my credentials, would need to set up separately in order for clone to work

## Get the Netlify CLI

```
npm i netlify-cli -g
netlify init
```

## Add FaunaDB

```
netlify addons:create fauna
netlify addons:auth fauna
```

## Run locally

```
yarn dev
```
