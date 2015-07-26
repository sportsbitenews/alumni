var ResourceList = React.createClass({
  render: function() {
    return (
      <div>
        {this.props.resources.map(r => <ResourceListElement key={r.id} {...r} />)}
      </div>
    );
  }
});
