class PostDetailFooter extends React.Component {
  render() {
    return (
      <div className='post-detail-footer'>
        <main className='post-detail-form'>
          <AnswerForm post_id={this.props.id} type={this.props.type} />
        </main>
        <aside>

        </aside>
      </div>
    )
  }
}
