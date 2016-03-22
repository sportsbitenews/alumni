var AlumniDirectory = React.createClass({
  getInitialState: function() {
    return { alumni: this.props.users };
  },

  render: function() {
    return <AlumniList users={this.state.alumni} />;
  }
});
