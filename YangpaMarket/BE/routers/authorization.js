const jwt = require("jsonwebtoken");
const secret = process.env.JWT_SECRET;

const isAuth = async (req, res, next) => {
  const auth = req.get("Authorization");

  if (!auth || !auth.startsWith("Bearer ")) {
    console.log("first");
    return res.json({ success: false, message: "Auth error, no key" });
  }

  const token = auth.split(" ")[1];

  jwt.verify(token, secret, (error, decoded) => {
    if (error) {
      return res.json({ success: false, message: `Auth error, auth failed\n${token},\n${secret} ` });
    } else {
      req.userID = decoded.uid;
      req.role = decoded.rol;
      // console.log(req);
      next();
    }
  });
};

module.exports = isAuth;
