import * as cdk from '@aws-cdk/core'
import * as ecs from '@aws-cdk/aws-ecs';
import * as ec2 from '@aws-cdk/aws-ec2';
import * as ecr from '@aws-cdk/aws-ecr';
import * as elb from '@aws-cdk/aws-elasticloadbalancingv2';
import { Duration, Stack } from '@aws-cdk/core';
import * as lambda from "@aws-cdk/aws-lambda";
import * as apigateway from "@aws-cdk/aws-apigateway";
import * as s3 from '@aws-cdk/aws-s3'
import * as s3deploy from '@aws-cdk/aws-s3-deployment'
import * as cf from '@aws-cdk/aws-cloudfront'
import { PriceClass } from '@aws-cdk/aws-cloudfront';


export const serviceName = 'noa-studio-finder'
// const hostHeader = 'wfhmaker.com'
// ↓これはCloudFront用なのでバージニア北部
const acmCertificateArn = 'hoge'
// CloudFrontのcustomOriginSourceに使う
const domainName = "hoge"

export class CdkDeployStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const websiteBucket = new s3.Bucket(this, 'WebsiteBucket', {
      websiteIndexDocument: 'index.html',
    });

    const distribution = new cf.CloudFrontWebDistribution(this, 'MyDistribution', {
      priceClass: PriceClass.PRICE_CLASS_200,
      // aliasConfiguration: {
      //   names: [hostHeader],
      //   acmCertRef: acmCertificateArn
      // },
      originConfigs: [
        {
          s3OriginSource: {
            s3BucketSource: websiteBucket
          },
          behaviors : [
            {
              minTtl: Duration.seconds(0),
              maxTtl: Duration.seconds(0),
              defaultTtl: Duration.seconds(0),
              isDefaultBehavior: true
            }
          ]
        }
      ],
      defaultRootObject: "index.html",
      comment: `${serviceName}本番`
   });

   new s3deploy.BucketDeployment(this, 'DeployWebsite', {
      sources: [s3deploy.Source.asset('../frontend/build')],
      destinationBucket: websiteBucket,
      distribution
    });
  }
}
