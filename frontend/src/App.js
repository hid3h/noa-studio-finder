import React from 'react';
import 'antd/dist/antd.css';
import './App.css';

import { Layout } from 'antd';

const { Header, Footer, Sider, Content } = Layout;

function App() {
  return (
    <>
      <Layout>
        <Header>Header</Header>
        <Content>Content</Content>
        <Footer>Footer</Footer>
      </Layout>
    </>
  );
}

export default App;
