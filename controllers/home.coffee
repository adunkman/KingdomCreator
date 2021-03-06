express = require 'express'
creator = require '../utils/creator'
Sets = require '../models/set'

module.exports = app = express()

app.get '/', (req, res, next) ->
   Sets.find({ inactive: { $ne: true }}).sort('_id').lean().exec (err, sets) ->
      return next(err) if err
      res.render 'home', sets: sets

app.get '/cards/kingdom', (req, res) ->
   setIds = req.query.sets?.split(',')
   replaceCards = req.query.replaceCards?.split(',')
   keepCards = req.query.keepCards?.split(',')
   types = req.query.types?.split(',')
   creator.createKingdom setIds, replaceCards, keepCards, types, (err, kingdom) ->
      res.json kingdom.toObject()
