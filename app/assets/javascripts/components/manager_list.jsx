var ManagerList = React.createClass({
  getInitialState() {
    return {
      managers: this.props.managers
    };
  },
  updateManagersList: function(managers) {
    this.setState({managers: managers});
  },
  render: function() {
    return (
      <div>
        {this.state.managers.map((manager, index) => {
          return (
            <div className="manager-box" key={index}>
              <div className="manager-avatar">
                <img className="avatar" src={manager.gravatar_url} alt="" />
              </div>
              <div className="manager-username">
                {manager.github_nickname}
              </div>
              <button className='manager-button manager-button-kill'
                  onClick={(e) => { this.handleRemoveClick(e, manager) }} >
                <i className="mdi mdi-window-close" />
              </button>
            </div>
          )
        })}
        <ManagerForm city={this.props.city_slug} updateManagers={this.updateManagersList} />
      </div>
    );
  },
  handleRemoveClick(e, manager) {
    e.preventDefault();
    axios.railsPost(
      Routes.set_manager_city_path(manager.city, { format: 'json' }),
      {
        'github_nickname': manager.github_nickname,
        'remove': true
      }
    ).then((response) => {
      this.updateManagersList(response.data.managers);
    });
  }
});
