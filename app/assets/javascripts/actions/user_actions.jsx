class UserActionsClass {
  getUsers(query, callback) {
    axios.railsGet(Routes.users_path({ query: query, format: 'json' }))
      .then((response) => callback(response.data))
  }

  update_profile(user_id, user_params_json) {
    return (dispatch) => {
      axios.railsPatch(Routes.edit_profile_path(user_id, { format: 'json' }), user_params_json)
        .then((response) => dispatch(response.data))
    }
  }
}

UserActions = alt.createActions(UserActionsClass);
