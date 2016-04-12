var AlumniListItem = React.createClass({

  render: function() {
    var mood = null;
    if (this.props.user.mood) {
      var mood = (<p>{'"' + this.props.user.mood + '"' }</p>);
    }
    var positionSummary = null;
    var positionLogo = null;
    if (this.props.user.position.title == 'Freelance') {
      var positionSummary = (<p>{this.props.user.position.title}</p>);
    } else {
      var positionSummary = (
        <div>
          <p><i>{this.props.user.position.title}</i></p>
          <p className="hidden-xs">{this.props.user.position.company}</p>
        </div>
      );
      var positionLogo = (
        <a href={"http://" + this.props.user.position.url}>
          <img src={"//logo.clearbit.com/" + this.props.user.position.url} />
        </a>
      );
    }
    var batch = null;
    if (this.props.user.batch) {
      var batch = (
        <p>
          <a href={Routes.batch_path(this.props.user.batch.id)}>
            Batch#{this.props.user.batch.slug} - {this.props.user.batch.city}
          </a>
        </p>
      );
    }
    return (
      <div className="alumni-card">
        <div className="row padded-1em">
          <div className="col-xs-2 col-xs-offset-0 col-sm-2 col-sm-offset-1 col-md-2 col-md-offset-2">
            <div className="alumni-card-avatar">
              <img className="pull-right" src={this.props.user.thumbnail} />
            </div>
          </div>
          <div className="col-xs-8 col-sm-3 col-md-2">
            <div className="alumni-card-body">
              <h5>
                <a href={Routes.profile_path(this.props.user.github_nickname)}>
                  {this.props.user.first_name} {this.props.user.last_name}
                </a>
              </h5>
              <div className='hidden-xs'>
                {batch}
                {mood}
              </div>
            </div>
          </div>
          <div className="col-xs-9 col-sm-3 col-md-1 text-right">
            <div className="alumni-card-position-summary">
              {positionSummary}
            </div>
          </div>
          <div className="col-xs-2 col-sm-1 col-md-1">
            <div className="alumni-card-position-logo">
              {positionLogo}
            </div>
          </div>
        </div>
      </div>
    );
  }
});

