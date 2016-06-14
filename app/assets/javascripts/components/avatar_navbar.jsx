class AvatarNavbar extends React.Component {
  constructor(props) {
    super(props)

    this.state = { menuOpen: false }
  }

  render() {

    var userMenuClasses = classNames({
      'user-menu': true,
      'is-open': this.state.menuOpen
    })

    var stop_impersonating_link = null;
    if (this.props.impersonating) {
      stop_impersonating_link = (
        <a href={Routes.stop_impersonating_path({return_to: this.props.current_path})} style={{color: 'red'}}>
          Stop
        </a>
      );
    }

    var cities_link = null;
    if (this.props.cities.length > 0) {
      cities_link = (
        <a href={Routes.cities_path()}>
          Dashboard
        </a>
      )
    }

    return(
      <div className='user-avatar' onMouseEnter={this.open} onMouseLeave={this.close}>
        <div className={userMenuClasses}>
          <a href={Routes.destroy_user_session_path()} style={{opacity: 0.3}}>Sign out</a>
          <hr/>
          <a href="http://lewagon-alumni.slack.com" target="_blank">Slack</a>
          <hr/>
          <a href={Routes.profile_path(this.props.user.github_nickname)}>My profile</a>
          <hr/>
          {cities_link}
          {cities_link == null ? null : <hr />}
          {stop_impersonating_link}
          {stop_impersonating_link == null ? null : <hr />}
        </div>
        <img onClick={this.open} className='avatar avatar-navbar' src={this.props.user.thumbnail} />
      </div>
    )
  }

  open = () => {
    this.setState({ menuOpen: true })
  }

  close = () => {
    this.setState({ menuOpen: false })
  }
}
