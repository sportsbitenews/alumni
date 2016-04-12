var AlumniListItem = React.createClass({

  render: function() {
    var badgeConnectedClasses = classNames({
      'badge-connected': true,
      'is-active': this.props.user.slack.connected
    })
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
          <span id="title">{this.props.user.position.title}</span> at
           <a className="user-profile-blue-link" href={"http://" + this.props.user.position_url + ".com"}>
            {" " + this.props.user.position.company}
          </a>
        </span>
      );
      //var this = that;
      var positionLogo = (
        <img className="avatar avatar-mini-logo" src={"//logo.clearbit.com/" + this.props.user.position_url + ".com"} onerror="this.src={that.props.user.position_alt_url}" />
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
    var slack = null;
    var mail = null;
    if (this.props.current_user) {
      var mail = (
        <div>
          <div className="user-profile-contact-tank">
            <div className="user-profile-contact-icons">
              <i className="mdi mdi-email-outline"></i>
            </div>
            <div className="user-profile-contact-links">
              <a href={"mailto:" + this.props.user.email} target='_blank' id='user-email'>
                {this.props.user.email}
              </a>
            </div>
          </div>
          <div className="user-profile-contact-pipe"></div>
        </div>
      );
      if (this.props.user.slack.uid) {
        var slack = (
          <div>
            <div className="user-profile-contact-tank">
              <div className="user-profile-contact-icons">
                <i className="mdi mdi-slack"></i>
              </div>
              <div className="user-profile-contact-links">
                <a href={this.props.user.slack.messages_url} target='_blank' id="user-slack">
                  @{this.props.user.slack.nickname}
                </a>
                <span className={badgeConnectedClasses}></span>
              </div>
            </div>
            <div className="user-profile-contact-pipe"></div>
          </div>
        );
      }
    }
    var batch = null;
    if (this.props.user.batch) {
      var batch = this.props.user.batch.name
    }
    return (
      <div className="col-xs-12 col-xs-offset-0 col-sm-8 col-sm-offset-2 col-md-5 col-md-offset-1 col-lg-3 col-lg-offset-1 padded-1em">
        <div className="user-profile-header-tank directory-card">
          <div className="user-profile-avatar">
            <img className="avatar" src={this.props.user.thumbnail} />
          </div>
          <div className="user-profile-summary">
            <h1>{this.props.user.first_name} {this.props.user.last_name}</h1>
            <h2>
              {positionLogo}
              {positionSummary}
            </h2>
            <div className="user-profile-contact">
              {slack}
              <div className="user-profile-contact-tank">
                <div className="user-profile-contact-icons">
                  <i className="mdi mdi-github-circle"></i>
                </div>
                <div className="user-profile-contact-links">
                  <a href={"http://github.com/" + this.props.user.github_nickname}  target='_blank'>
                    {this.props.user.github_nickname}
                  </a>
                </div>
              </div>
              <div className="user-profile-contact-pipe"></div>
              {mail}
              <div className="user-profile-contact-tank">
                <div className="user-profile-contact-icons">
                  <i className="mdi mdi-map-marker-radius"></i>
                </div>
                <div className="user-profile-contact-links">
                  {this.props.user.cities}{batch}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
});

