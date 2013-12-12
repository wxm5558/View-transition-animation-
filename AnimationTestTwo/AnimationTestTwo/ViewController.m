//
//  ViewController.m
//  AnimationTestTwo
//
//  Created by xiaomanwang on 13-12-12.
//  Copyright (c) 2013年 xiaomanwang. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()
@property(nonatomic,retain)UIImageView*imageViewOne;
@property(nonatomic,retain)UIImageView*imageViewTwo;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)dealloc
{
	self.imageViewOne = nil;
	self.imageViewTwo = nil;
	[super dealloc];
}

- (IBAction)dosome:(id)sender
{
	[self.view addSubview:self.imageViewOne];
	[self.view addSubview:self.imageViewTwo];
	[self doAnimation];
}

- (UIImageView*)imageViewOne
{
	if(_imageViewOne == nil)
	{
		_imageViewOne = [UIImageView new];
		[_imageViewOne setImage:[UIImage imageNamed:@"background_s1.jpg"]];
	}
	_imageViewOne.frame = self.view.bounds;
	return _imageViewOne;
}

- (UIImageView*)imageViewTwo
{
	if(_imageViewTwo == nil)
	{
		_imageViewTwo = [UIImageView new];
		[_imageViewTwo setImage:[UIImage imageNamed:@"background_s2.jpg"]];
	}
	_imageViewTwo.frame = self.view.bounds;
	return _imageViewTwo;
}

- (void)removeAll
{
	[self.imageViewOne removeFromSuperview];
	[self.imageViewTwo removeFromSuperview];
}

double radianFromDegree(float degrees)
{
    return (degrees / 180) * M_PI;
}

#define kDuration 2
- (void)doAnimation
{
	CATransform3D tp = CATransform3DIdentity;
    tp.m34 = 1.0/ -500;
    tp = CATransform3DTranslate(tp, -1*self.view.frame.size.width, -10.0f, self.view.frame.size.width);
    tp = CATransform3DRotate(tp, radianFromDegree(20), 0.0f,1.0f, 0.8f);
    self.imageViewOne.layer.transform = tp;
	self.imageViewOne.layer.opacity = 0.0f;
    [UIView animateWithDuration:kDuration
					 animations:^{
						 CATransform3D t = CATransform3DIdentity;
						 t.m34 = 1.0/ -500;
						 t = CATransform3DRotate(t, radianFromDegree(5.0f), 0.0f,0.0f, 1.0f);
						 t = CATransform3DTranslate(t, self.view.frame.size.width * 2, 0.0f, -400.0);
						 t = CATransform3DRotate(t, radianFromDegree(-45), 0.0f,1.0f, 0.0f);
						 t = CATransform3DRotate(t, radianFromDegree(50), 1.0f,0.0f, 0.0f);
						 self.imageViewTwo.layer.transform = t;
						 self.imageViewTwo.layer.opacity = 0.0;
						 
						 CATransform3D t2 = CATransform3DIdentity;
						 t2.m34 = 1.0/ -500;
						 t2 = CATransform3DTranslate(t2, 0.0f, 0.0f, 0.0);
						  self.imageViewOne.layer.transform = t2;
						  self.imageViewOne.layer.opacity = 1.0;
					 }
					 completion:^(BOOL finished){
						 [self performSelector:@selector(removeAll) withObject:nil afterDelay:kDuration+1];
						 self.imageViewOne.layer.transform = CATransform3DIdentity;
						self.imageViewTwo.layer.transform = CATransform3DIdentity;
					 }];

}
@end
