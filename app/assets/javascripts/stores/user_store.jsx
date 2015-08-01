class UserStoreClass {
  constructor() {
    this.users = {};  // id => User
    this.bindListeners({
      updateUsers: UserActions.fetchUsers
    });
  }

  updateUsers(users) {
    _.each(users, (user) => this.users[user.id] = user);
  }

  getUser(id) {
    return this.users[id];
  }
}

var UserStore = alt.createStore(UserStoreClass, 'UserStore');
