class AnswerForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = this.initialState();
  }

  componentDidMount() {
    AnswerStore.listen(this.onStoreChange.bind(this));
    PostStore.listen(this.onPostStoreChange.bind(this));
  }

  componentWillUnmount() {
    AnswerStore.unlisten(this.onStoreChange.bind(this));
    PostStore.unlisten(this.onPostStoreChange.bind(this));
  }

  render() {
    var formClasses = classNames({
      'answer-form': true,
      'is-previewed': this.state.preview,
      'is-editing': this.state.editing,
      'is-blank': this.state.blank,
      'is-sending-post': this.state.pendingPost
    });

    return(
      <div className={formClasses}>
        <input placeholder="Respond a nice thing" onFocus={this.onFocusInput.bind(this)} ref="content" className='answer-form-input' onKeyUp={this.onKeyUp.bind(this)} onKeyDown={this.onKeyDown.bind(this)} />
        <div className='answer-form-preview' dangerouslySetInnerHTML={{__html: this.state.renderedContent}}></div>
        <div className='answer-form-actions'>
          <svg xmlns="http://www.w3.org/2000/svg" width="208" height="128" viewBox="0 0 208 128"><rect width="198" height="118" x="5" y="5" ry="10" stroke="#000" stroke-width="10" fill="none"/><path d="M30 98v-68h20l20 25 20-25h20v68h-20v-39l-20 25-20-25v39zM155 98l-30-33h20v-35h20v35h20z"/></svg>

          <menu className="source-tile-menu" onClick={this.handleClick} type="toolbar">

            <div className="toggle-switch"></div>
            <div className="label-container">
              <label className='label-on'>on</label>
              <label className='label-off'>off</label>
            </div>
          </menu>
        </div>
      </div>
    )
  }

  onFocusInput(e) {
    e.preventDefault();
    this.setState({
      editing: true
    })
  }

  resetForm() {
    this.setState(this.initialState());
    this.content().value = "";
  }

  goToBottom(e) {
    window.scroll(0, document.body.scrollHeight)
  }

  onStoreChange(store) {
    var newAnswer = store.getNewAnswer();
    this.setState({
      renderedContent: newAnswer.rendered_content
    })
  }

  onPostStoreChange(store) {
    if (this.state.pendingPost){
      this.resetForm();
      this.content().blur();
      this.goToBottom();
    }
  }

  onEditClick(e) {
    e.preventDefault();
    this.setState({
      preview: false
    })
  }

  onPreviewClick(e) {
    e.preventDefault();
    this.setState({
      preview: true
    })
    AnswerActions.preview(this.content().value);
  }

  onKeyDown(e) {
    if (e.which == 13 && (e.metaKey || e.ctrlKey)) {
      AnswerActions.post(this.props.type, this.props.post_id, this.content().value);
      this.setState({
        pendingPost: true
      })
    }
    else if (e.which == 27) {
      this.resetForm();
      this.content().blur();
    }
  }

  onKeyUp(e) {
    if (this.content().value == "") {
      this.setState({
        blank: true
      })
    } else if (this.state.blank) {
      this.setState({
        blank: false
      })
    }
  }

  initialState() {
    return {
      editing: false,
      preview: false,
      pendingPost: false,
      renderedContent: null,
      blank: true
    };
  }

  content() {
    return React.findDOMNode(this.refs.content);
  }
}