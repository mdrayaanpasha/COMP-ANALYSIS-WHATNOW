import express from "express";
import { PrismaClient } from "@prisma/client";
const app = express();
app.use(express.json());
const prisma = new PrismaClient();


app.get("/inject",async(req,res)=>{
    const injectValue = ["rayaan","ayaan","taylor swift","ophelia"];

    const vals = injectValue.map(async(ele)=>{
        await prisma.user.create({
            data:{name:ele}
        })
    })
    return res.status(200).json({"message":"sucess","users":vals})
})
app.get("/users", async (req, res) => {
  const users = await prisma.user.findMany();
  res.json(users);
});

app.listen(3000, () => {
  console.log("Server running on port 3000");
});
