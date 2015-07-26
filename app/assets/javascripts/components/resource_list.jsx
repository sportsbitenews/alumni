var ResourceList = React.createClass({
  render: function() {
    return (
      <div>
        {this.props.resources.map(function(resource) {
          return (
            <ResourceListElement key={resource.id} {...resource}/>
          );
        })}
      </div>
    );
  }
});
