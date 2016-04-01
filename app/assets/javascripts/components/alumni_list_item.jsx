var AlumniListItem = React.createClass({

  render: function() {
    var mood = null;
    if (this.props.user.mood) {
      var mood = (<p>{'"' + this.props.user.mood + '"' }</p>);
    }
    var positionSummary = null;
    var positionLogo = null;
    if (this.props.user.position.title == 'Freelance') {
      var positionSummary = (<span>{this.props.user.position.title}</span>);
      var positionLogo = (<img className="avatar avatar-mini-logo" src={this.props.user.position_url} />);
    } else {
      var positionSummary = (
        <span>
          <span id="title">{this.props.user.position.title}</span>
          <a className="user-profile-blue-link" href={"http://" + this.props.user.position_url + ".com"}>
            {this.props.user.position.company}
          </a>
        </span>
      );
      //var this = that;
      //var positionLogo = (<img className="avatar avatar-mini-logo" src={"//logo.clearbit.com/" + this.props.user.position_url + ".com"} onerror="this.src={that.props.user.position_alt_url}" />);
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
      <div className="col-xs-12 col-xs-offset-0 col-sm-8 col-sm-offset-2 col-md-5 col-md-offset-1">
        <div className="user-profile-header-tank">
          <div className="user-profile-avatar">
            <img className="avatar" src={this.props.user.thumbnail} />
          </div>
        </div>
        <div className="user-profile-summary">
          <h1>{this.props.user.first_name} {this.props.user.last_name}</h1>
          <h2>
            {positionLogo}
            {positionSummary}
          </h2>

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
    );
  }
});

