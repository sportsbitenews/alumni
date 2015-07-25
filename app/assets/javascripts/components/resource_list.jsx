var ResourceList = React.createClass({
  render: function() {
    return (
      <div>
        {this.props.resources.map(function(resource) {
          return (
            <Resource key={resource.id} {...resource}/>
          );
        })}
      </div>
    );
  }
});
