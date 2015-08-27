class PopoverUser extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    return(
      <div className='user-popover-wrapper'>
        <strong className='post-item-text-target' ref='target' onClick={this.openProfile.bind(this)}>
          {this.props.user.github_nickname}
        </strong>
      </div>
    )
  }

  openProfile() {
    window.open(Routes.profile_path(this.props.user.github_nickname), '_self')
  }

}
