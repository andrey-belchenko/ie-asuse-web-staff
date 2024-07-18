"use strict";
const dotenv = require("dotenv");
dotenv.config();
import express from "express";
import * as mongoDB from "mongodb";

// import fetch from "node-fetch";
// import * as kisurFile from "./kisurFile";
// const kisurFile = require("./kisurFile");

// const ObjectID = require("mongodb").;
import cors from "cors";

require("babel-polyfill");
const query = require("devextreme-query-mongodb");
const bodyParser = require("body-parser");
// const contentDisposition = require("content-disposition");

import contentDisposition from "content-disposition";
import { getFileData } from "./kisurFile";
const app = express();
// app.use(bodyParser.json());
app.use(bodyParser.json({ limit: "50mb" }));
// app.use(bodyParser.urlencoded({ limit: "10mb", extended: true }));
const port = process.env.adp_api_port;
const mongoDbUrl = process.env.adp_mongo_uri;
console.log(`mongoDbUrl: ${mongoDbUrl}`);
const dbName = process.env.adp_mongo_exchange_db;
console.log(`dbName: ${dbName}`);
app.use(cors());

//Chat GPT
// Task:
// Function accepts object that can contain nested objects and arrays with any nesting level.
// Function should replace all dates presented as string in format like "2023-08-02T21:00:00.000Z" with Date() objects with correct values.
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
      const db = client.db(req.body.database || dbName);
      const collection = db.collection(req.body.collection);
      console.log("Collection: " + collection.collectionName);
      let results = {};
      if (req.body.filter) {
        let filter = req.body.filter;

        for (let name in filter) {
          if (filter[name]) {
            if (filter[name].$oid) {
              filter[name] = new mongoDB.ObjectId(filter[name].$oid);
            }
          }
        }
        console.log(JSON.stringify({ filter: req.body.pipeline }));
        results = { data: await collection.find(filter).toArray() };
      } else if (req.body.pipeline) {
        console.log(JSON.stringify({ pipeline: req.body.pipeline }));
        results = {
          data: await collection.aggregate(req.body.pipeline).toArray(),
        };
      } else if (req.body.collection == "databases") {
        const adminDb = client.db("admin");
        const databasesList = await adminDb.admin().listDatabases();
        results = {
          data: databasesList.databases,
        };
      } else {
        let loadOptions = replaceDateStrings(req.body.loadOptions);
        console.log(JSON.stringify({ loadOptions: req.body.pipeline }));
        results = await query(collection, loadOptions);
      }
      res.json(results);
    });
  } catch (error) {
    next(error);
  }
});

// const pipeline = [
//   {
//     $group: {
//       _id: null,
//       maxChangedAt: { $max: '$changedAt' }
//     }
//   }
// ];

// const result = await collection.aggregate(pipeline).toArray();
// const maxChangedAt = result[0]?.maxChangedAt;

app.get("/file/:db/:id/:filename?", async (req: any, res, next) => {
  logRequest(req);
  let entityId = req.params.id;
  let dbName = req.params.db;
  try {
    await useMongo(async (client: mongoDB.MongoClient) => {
      const db = client.db(dbName);
      const collection = db.collection("dm_PsrFile");
      const filter = { id: entityId };
      const fileInfo = await collection.findOne(filter);
      const fileBuffer = await getFileData(fileInfo.model.PsrFile_fileId);
      // res.setHeader("Content-Type", "application/octet-stream");
      res.setHeader(
        "Content-Type",
        getFileContentType(fileInfo.model.PsrFile_mimeType)
      );
      let type = "attachment";
      if (req.params.filename) {
        type = "inline";
      }
      res.setHeader(
        "Content-Disposition",
        contentDisposition(fileInfo.model.IdentifiedObject_name, {
          type: type,
        })
      );
      res.send(fileBuffer);
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
    // throw "Error1";
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

function getFileContentType(fileExtension: string): string {
  switch (fileExtension.toLowerCase()) {
    case "html":
      return "text/html";
    case "css":
      return "text/css";
    case "js":
      return "application/javascript";
    case "json":
      return "application/json";
    case "xml":
      return "application/xml";
    case "jpeg":
      return "image/jpeg";
    case "jpg":
      return "image/jpeg";
    case "png":
      return "image/png";
    case "gif":
      return "image/gif";
    case "pdf":
      return "application/pdf";
    case "doc":
      return "application/msword";
    case "docx":
      return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
    case "xls":
      return "application/vnd.ms-excel";
    case "xlsx":
      return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    case "ppt":
      return "application/vnd.ms-powerpoint";
    case "pptx":
      return "application/vnd.openxmlformats-officedocument.presentationml.presentation";
    case "txt":
      return "text/plain";
    case "csv":
      return "text/csv";
    case "zip":
      return "application/zip";
    default:
      return "application/octet-stream"; // Default value for unknown file types
  }
}
