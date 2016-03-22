var AlumniDirectory = React.createClass({
  getInitialState: function() {
    return { alumni: users };
  },

  render: function() {
    return <AlumniList users={this.state.alumni} />;
  }
}
