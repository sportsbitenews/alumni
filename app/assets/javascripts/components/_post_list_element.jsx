class PostListElement extends React.Component {
  render() {
    var path = `${this.props.type.toLowerCase()}_path`;
    var link = Routes[path]({ id: this.props.id });

    return (
      <a>
        {this.content()}
      </a>
    )
  }
}
