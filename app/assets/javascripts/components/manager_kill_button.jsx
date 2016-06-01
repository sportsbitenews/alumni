var ManagerKillButton = React.createClass({
  render: function() {
    return (
      <button className='manager-button manager-button-kill' onclick={this.handleKillClick} >
        <i className="mdi mdi-window-close" />
      </button>
    );
  },
  handleKillClick(e) {
    e.preventDefault();
    axios.railsPost(
      Routes.set_manager_city_path(this.props.city, { format: 'json' }),
      {
        'github_nickname': this.props.github_nickname,
        'kill': true
      }
    ).then((response) => {
      this.props.updateManagers(response.data.managers);
    });
  }
});
