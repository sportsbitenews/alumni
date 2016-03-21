var AlumniListItem = React.createClass({
  render: function() {
    return (
      <div className="row">
        <div className="col-xs-3">
          <img src={this.props.user.thumbnail} />
        </div>
        <div className="col-xs-9">
          <h3>
            <a href="#" target="_blank">{this.props.user.first_name} {this.props.user.last_name}</a>
          </h3>
        </div>
      </div>
    );
  }
});

