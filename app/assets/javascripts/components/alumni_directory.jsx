var AlumniDirectory = React.createClass({
  getInitialState: function() {
    return { alumni: this.props.users };
  },

  render: function() {
    return (
      <div>
        <AlumniSearch />
        <AlumniList users={this.state.alumni} />
      </div>
    );
  }
});
