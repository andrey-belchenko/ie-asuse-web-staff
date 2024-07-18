"use strict";
console.log("starting...")
const dotenv = require("dotenv");
dotenv.config();
import express from "express";
import * as mongoDB from "mongodb";

import cors from "cors";

require("babel-polyfill");
const query = require("devextreme-query-mongodb");
const bodyParser = require("body-parser");

const app = express();
app.use(bodyParser.json({ limit: "50mb" }));
const port = process.env.API_PORT;
const mongoDbUrl = process.env.MONGO_URI;
console.log(`mongoDbUrl: ${mongoDbUrl}`);
app.use(cors());

function replaceDateStrings(obj: any) {
  // Check if the input is an object
  if (typeof obj === "object" && obj !== null) {
    // Iterate over each key-value pair in the object
    for (let key in obj) {
      // Check if the value is a string
      if (typeof obj[key] === "string") {
        // Check if the string matches the date format
        if (/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z$/.test(obj[key])) {
          // Replace the string with a Date object
          obj[key] = new Date(obj[key]);
        }
      }
      // Check if the value is an object or an array
      else if (typeof obj[key] === "object" && obj[key] !== null) {
        // Recursively call the function for nested objects or arrays
        replaceDateStrings(obj[key]);
      }
    }
  }
  return obj;
}

app.get("/test", async (req: any, res) => {
  logRequest(req);
  res.json({ response: "ОК" });
});

app.post("/query", async (req: any, res, next) => {
  try {
    logRequest(req);
    await useMongo(async (client: mongoDB.MongoClient) => {
      const db = client.db(req.body.database);
      const collection = db.collection(req.body.collection);
      console.log("Collection: " + collection.collectionName);
      let loadOptions = replaceDateStrings(req.body.loadOptions);
      console.log(JSON.stringify({ loadOptions: req.body.pipeline }));
      let results = await query(collection, loadOptions);
      res.json(results);
    });
  } catch (error) {
    next(error);
  }
});

async function useMongo(
  operations: (client: mongoDB.MongoClient) => Promise<void>
) {
  let client: mongoDB.MongoClient;
  try {
    client = new mongoDB.MongoClient(mongoDbUrl);
    await client.connect();
    await operations(client);
  } finally {
    try {
      client.close();
    } catch {}
  }
}

function logRequest(req: any) {
  console.log(new Date());
  console.log(req.originalUrl);
  if (req.body) {
    try {
      console.log(JSON.stringify(req.body));
    } catch {
      console.log(req.body);
    }
  }
}

app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
