import express from "express";
import dotenv from "dotenv";
dotenv.config()

const PORT = process.env.PORT

const app = express()

app.get("/",async(req,res)=>{
    return res.json({"message: ":"hello world"})
})


app.listen(PORT,()=>{
    console.log(`running server on: http://localhost:${PORT}`)
})