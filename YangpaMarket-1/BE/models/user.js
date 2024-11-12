const Sequelize = require('sequelize');

class User extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
      {
        userName: {
          type: Sequelize.STRING(50),
          allowNull: false,
          unique: true,
        },
        password: {
          type: Sequelize.STRING(200),
          allowNull: false,
        },
        profile: {
          type: Sequelize.STRING(200),
          allowNull: true,
        },
      },
      {
        sequelize,
        timestamps: true,
        paranoid: true,
        modelName: 'User',
        tableName: 'user',
      }
    );
  }

  static associate(db) {
    db.User.hasMany(db.Sale, { foreignKey: 'userID', sourceKey: 'id' });
  }
}

module.exports = User;
