var AlumniList = React.createClass({
  render: function() {
    return (
      <div>
        {this.props.users.map(function(user){
          return <AlumniListItem user={user} />;
        })}
      </div>
    );
  }
});
