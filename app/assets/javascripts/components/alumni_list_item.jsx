var AlumniListItem = React.createClass({
  render: function() {
    return (
      <div className="row padded-1em">
        <div className="col-xs-3 col-xs-offset-1 col-sm-2 col-sm-offset-1">
          <img className="user-profile-avatar" src={this.props.user.thumbnail} />
        </div>
        <div className="col-xs-8 col-sm-4">
          <h3>
            <a href={Routes.profile_path(this.props.user.github_nickname)}>{this.props.user.first_name} {this.props.user.last_name}</a>
          </h3>
          <p>
            <a href={Routes.batch_path(this.props.user.batch.id)}>
              Batch#{this.props.user.batch.slug} - {this.props.user.batch.city}
            </a>
          </p>
          <p>"Change life, learn to code"</p>
        </div>
        <div className="col-xs-10 col-xs-offset-1 col-sm-4">
          <p></p>
        </div>
      </div>
    );
  }
});

