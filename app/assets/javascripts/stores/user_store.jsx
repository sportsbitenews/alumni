class UserStoreClass {
  constructor() {
    this.users = {};  // id => User
    this.bindListeners({
      updateUser: UserActions.fetchUser
    });
  }

  updateUser(user) {
    this.users[user.id] = user;
  }

  getUser(id) {
    return this.users[id];
  }
}

var UserStore = alt.createStore(UserStoreClass, 'UserStore');
