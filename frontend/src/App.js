import React, { useState } from 'react';
import 'antd/dist/antd.css';
import './App.css';

import { Layout } from 'antd';
import { Button } from 'antd';
import { SearchOutlined } from '@ant-design/icons';

const { Footer, Content } = Layout;

const title = "ノアスタジオかんたん検索(非公式)"

function App() {
  const [loading, setLoading] = useState(false)


  function search() {
    setLoading(true)
  }

  return (
    <>
      <Layout>
        <h1>{title}</h1>
        <Content>
          <div>
            <Button type="primary" icon={<SearchOutlined />} size='large' loading={loading} onClick={search}>
              スタジオ検索
            </Button>
          </div>
        </Content>
        <Footer>Footer</Footer>
      </Layout>
    </>
  );
}

export default App;
