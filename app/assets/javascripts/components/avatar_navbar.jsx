class AvatarNavbar extends React.Component {
  constructor(props) {
    super(props)

    this.state = { menuOpen: false }
  }

  render() {

    userMenuClasses = classNames({
      'user-menu': true,
      'is-open': this.state.menuOpen
    })

    return(
      <div className='user-avatar' onMouseLeave={this.handleMouseLeave.bind(this)}>
        <div className={userMenuClasses}>
          <a href={Routes.destroy_user_session_path()} style={{opacity: 0.3}}>Sign out</a>
          <hr/>
          <a href="http://lewagon-alumni.slack.com" target="_blank">Slack</a>
          <hr/>
          <a href="http://kitt.lewagon.org" target="_blank">Kitt</a>
          <hr/>
          <a href={Routes.profile_path(this.props.user.github_nickname)}>My profile</a>
          <hr/>
        </div>
        <img onClick={this.handleClick.bind(this)} onMouseEnter={this.handleMouseEnter.bind(this)} className='avatar avatar-navbar' src={this.props.user.thumbnail} />
      </div>
    )
  }

  handleClick() {
    this.setState({ menuOpen: true })
  }

  handleMouseLeave() {
    this.setState({ menuOpen: false })
  }

  handleMouseEnter() {
    this.setState({ menuOpen: true })
  }
}
