class AvatarNavbar extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      menuOpen: false
    }
  }

  render() {

    userMenuClasses = classNames({
      'user-menu': true,
      'is-open': this.state.menuOpen
    })
    return(
      <div className='user-avatar' onMouseLeave={this.handleMouseLeave.bind(this)}>
        <div className={userMenuClasses}>
          <a href='users/sign_out' method='patch'>Sign out</a>
          <hr/>
          <a href={Routes.profile_path(this.props.user.github_nickname)}>My profile</a>
          <hr/>
        </div>
        <img onClick={this.handleClick.bind(this)} onMouseEnter={this.handleMouseEnter.bind(this)} className='avatar avatar-navbar' src={this.props.user.gravatar_url} />
      </div>
    )
  }

  handleClick() {
    this.setState({
      menuOpen: true
    })
  }

  handleMouseLeave() {
    this.setState({
      menuOpen: false
    })
  }

  handleMouseEnter() {
    this.setState({
      menuOpen: true
    })
  }
}
