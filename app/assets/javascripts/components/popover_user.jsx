class PopoverUser extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      show: false,
      hovered: false
    }
  }
  render() {
    return(
      <div className='user-popover-wrapper'>
        <strong className='post-item-text-target' ref='target' onClick={this.openProfile.bind(this)} onMouseOut={this.toggle.bind(this)} onMouseOver={this.toggle.bind(this)}> {this.props.user.github_nickname}</strong>
        <ReactBootstrap.Overlay
          placement='bottom'
          show={this.state.show}
          onHide={() => this.setState({ show: false })}
          delayShow={200}
          container={this}
          onExit={this.onExit}
          target={ props => React.findDOMNode(this.refs.target)} >

            <div className='user-popover pop' onMouseOver={this.mouseOverhandler.bind(this)} onMouseOut={this.mouseOuthandler.bind(this)}>
              <img src={this.props.user.gravatar_url} />
              <div className='user-popover-name text-center'>
                @{this.props.user.github_nickname}
              </div>
            </div>


        </ReactBootstrap.Overlay>
      </div>
    )
  }

  mouseOverhandler() {
    this.setState({
      hovered: true
    })
    this.toggle()
  }

  openProfile() {
    window.open(Routes.profile_path(this.props.user.github_nickname), '_self')
  }

  toggle() {
    that = this
    setTimeout(function(){
      if (that.state.show) {
        setTimeout(function(){
          if(that.state.hovered) {
            that.setState({
              show: true
            })
          } else {
            that.setState({
              show: false
            })
          }
        }, 500)
      } else {
        that.setState({
          show: true
        })
      }
    }, 200)
  }

  mouseOuthandler() {
    this.setState({
      hovered: false
    })
    this.toggle()
  }
}
