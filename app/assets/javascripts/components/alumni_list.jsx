var AlumniList = React.createClass({
  render: function() {
    return (
      <div classNamne="row">
        {this.props.users.map(function(user, index){
          return <AlumniListItem key={index} user={user} />;
        })}
      </div>
    );
  }
});
