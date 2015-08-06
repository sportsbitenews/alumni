class QuestionForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      preview: false
    }
  }

  render() {
    var errorTitle = "";
    var errorContent = "";
    return(
      <form action={Routes.questions_path()} method='post'>
        <div className='container'>
          <div className='post-submissions-row'>
            <label htmlFor='title'>
              <i className='mdi mdi-crown'></i>Title
            </label>
            <input ref='title' defaultValue={this.props.question.title} placeholder="The title of the resource" name='title' />
            <div className='errors'>
              {errorTitle}
            </div>
          </div>
          <div className='post-submissions-row'>
            <label htmlFor='tagline'>
              <i className='mdi mdi-message-text-outline'></i>Content
            </label>
            <textarea ref='tagline' defaultValue={this.props.question.tagline} placeholder='Describe the resource' name='tagline' />
            <div className='errors'>
              {errorContent}
            </div>
          </div>
        </div>
        <div className='post-submissions-submit'>
          <input type='submit' className='button' value='Post it' />
        </div>
      </form>
    )
  }

  componentDidMount() {
    AnswerStore.listen(this.onStoreChange.bind(this));
  }

  componentWillUnmount() {
    AnswerStore.unlisten(this.onStoreChange.bind(this));
  }

  onStoreChange(store) {
    if (this.state.preview) {
      console.log(store)
    }
  }

  onPreviewClick(e) {
    e.preventDefault();
    this.setState({
      preview: true
    })
    if (!this.state.blank) {
      AnswerActions.preview(this.content().value);
    }
  }
}
