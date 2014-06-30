#!/usr/bin/Rscript

library(methods)
library(rJava)
library(RMongo)
library(rjson)

args <- commandArgs(TRUE)
phenomenon <- args[1]
collection <- args[2]

dbm <- mongoDbConnect("sensite", host="ds033699.mongolab.com", port=33699)
auth <- dbAuthenticate(dbm, "sensite130", "sensite130")

associationRecord <- dbGetQuery(dbm, collection, sprintf("{phenomenon: \"%s\"}", phenomenon))[1, ]
sensors <- do.call(rbind, fromJSON(associationRecord[, "association"]))


X11()
par(las=2)
par(mar=c(10, 5, 5, 2))
with(mtcars, barplot(unlist(sensors[, 2]), names.arg=unlist(sensors[, 1]), main=sprintf("Phenomenon: %s", phenomenon), ylab="Count"))
ignore <- locator(1)
