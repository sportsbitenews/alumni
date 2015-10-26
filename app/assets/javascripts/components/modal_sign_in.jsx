class ModalSignIn extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      isActive: false,
      signInParams: {}
    }
  }

  render() {

    var cC = classNames({
      'modal-sign-in': true,
      'is-active': this.state.isActive
    })

    var scenario = this.state.signInParams.scenario;

    if (scenario === 'post_answer') {
      var scenarioAction = 'and publish your answer'
    } else if (scenario === 'upvote') {
      var scenarioAction = 'and upvote'
    }

    return(
      <div className={cC} onClick={this.escape.bind(this)}>
        <div className='modal-sign-in-content'>
          <div className='modal-sign-in-title'>
            Please sign in to do that
          </div>
          <div className='text-center'>
            <a className='button button-success' href={Routes.user_omniauth_authorize_path('github', this.state.signInParams)}>
              Sign in {scenarioAction} automatically!
            </a>
          </div>
        </div>
      </div>
    )
  }

  componentDidMount() {
    PubSub.subscribe('displayModal', (msg, data) => {
      this.setState({
        isActive: true,
        signInParams: data
      })
    })
  }

  escape() {
    this.setState({
      isActive: false
    })
  }
}
