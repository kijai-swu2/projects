// require("./models/sync")();

const express = require("express");
const morgan = require("morgan");
const dotenv = require("dotenv");
dotenv.config();
const port = process.env.PORT || 3000;
const app = express();
const memberRouter = require("./routers/memberRouter");
const saleRouter = require("./routers/saleRouter");
const imageRouter = require("./routers/imageRouter");
const checkAuth = require("./routers/authorization");
app.use(morgan("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/sales", checkAuth);
app.use("/sales", saleRouter);
app.use("/members", memberRouter);
app.use("/images", imageRouter);
app.use((_, res) => {
  res.status(404).json({ success: false, token: "", message: "요청이 잘못됨" });
});
app.listen(port);
